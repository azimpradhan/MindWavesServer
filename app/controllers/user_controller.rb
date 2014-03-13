class UserController < ApplicationController
  require 'fileutils'

  def index
    users = User.all
    render :json => users

  end



  def create
    puts "post request was made!"
    puts params
    user = User.where(:udid => params[:udid]).first_or_create!
    user.avatar_id = params[:avatar_id]
    user.lat = params[:lat]
    user.long = params[:long]
    user.udid = params[:udid]

    #upload sound here
    #"soundfile"=>#<ActionDispatch::Http::UploadedFile:0x007fd5751e20d8 @original_filename="stuff.wav", @content_type="audio/wav", @headers="Content-Disposition: form-data; name=\"soundfile\"; filename=\"stuff.wav\"\r\nContent-Type: audio/wav\r\n", @tempfile=#<File:/var/folders/jp/_6cbjh9112j_6fl8482n7zj80000gn/T/RackMultipart20140313-72687-1xugqvk>>}
    tmp = params[:soundfile].tempfile
    file = File.join("public/sound", params[:udid] + ".wav")
    FileUtils.cp tmp.path, file


    user.sound_filename = params[:udid] + ".wav"
    user.save!
    render :nothing => true
  end

  def show
    user = User.find_by_udid(params[:id])
    render :json => user
  end


end
