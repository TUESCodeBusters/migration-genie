require 'google/cloud/vision'
require 'mini_magick'
require 'google/cloud/storage'
require_relative '../assets/settings/animal_names'

class SightingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sighting, only: [:show, :edit, :update, :destroy]

  # GET /sightings
  # GET /sightings.json
  def index
    @sightings = Sighting.all
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
  end

  # GET /sightings/new
  def new
    @sighting = Sighting.new
  end

  # GET /sightings/1/edit
  def edit
  end

  # POST /sightings
  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)
    @sighting.user_id = current_user.id

    respond_to do |format|
      if @sighting.save
        upload_photo(@sighting.photo)
        format.html { redirect_to @sighting, notice: 'Sighting was successfully created.' }
        format.json { render :show, status: 
        :created, location: @sighting }
      else
        format.html { render :new }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sightings/1
  # PATCH/PUT /sightings/1.json
  def update
    respond_to do |format|
      if @sighting.update(sighting_params)
        format.html { redirect_to @sighting, notice: 'Sighting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sighting }
      else
        format.html { render :edit }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sightings/1
  # DELETE /sightings/1.json
  def destroy
    @sighting.destroy
    respond_to do |format|
      format.html { redirect_to sightings_url, notice: 'Sighting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sighting
      @sighting = Sighting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sighting_params
      params.require(:sighting).permit(:reporter, :photo)
    end

    def take_animal_name_from_photo(photo)
      result = Hash.new
      begin
        image = MiniMagick::Image.open(photo)

        latitude = image.exif['GPSLatitude'].split(',')
        longtitude = image.exif['GPSLongitude'].split(',')

        result['latitude'] = GPS_to_latlong(latitude)
        result['longtitude'] = GPS_to_latlong(longtitude)
      rescue Exception
      end
      begin
        # Your Google Cloud Platform project ID
        project_id = "420862347889-nuebrnckmge77dcrce8pff0i2k9ek3rb.apps.googleusercontent.com"

        # Instantiates a client
        vision = Google::Cloud::Vision.new project: project_id

        # Performs label detection on the image file
        parsed_data = vision.image(photo).labels
        parsed_data.each do |animal|
          if ANIMAL_NAMES.include?(animal.description.downcase)
            result['animal_name'] = animal.description.downcase
            return result
          end
        end
      rescue Exception
      end
      return result
    end


    def GPS_to_latlong(arr)
      lt = Array.new
      arr.each do |i|
        nums = i.split('/')
        lt << nums[0].to_i / nums[1].to_i
      end
      lt[0].to_f + lt[1].to_f/60 + lt[2].to_f/3600  
    end

    def upload_photo(photo)
      project_id = "420862347889-nuebrnckmge77dcrce8pff0i2k9ek3rb.apps.googleusercontent.com"

      storage = Google::Cloud::Storage.new project: project_id

      bucket = storage.bucket "migration-genie-photos"
      file = bucket.create_file "./public#{photo.url}", photo.url.split('/')[photo.url.split('/').length - 1]
      file.acl.public!
      
      @sighting.photo = file.url
      @sighting.save

    end
end
