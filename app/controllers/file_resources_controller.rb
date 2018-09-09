class FileResourcesController < ApplicationController
  before_action :set_file_resource, only: [:destroy, :download_file, :pet_report, :product_report_xlsx]
  include UploadFile

  # GET /file_resources
  # GET /file_resources.json
  def index
    @file_resources = FileResource.all
  end

  # GET /file_resources/new
  def new
    @file_resource = FileResource.new
  end


  # POST /file_resources
  # POST /file_resources.json
  def create
    #recibo nombre original del archivo
    name = params[:file_resource][:name].original_filename

    #remuevo extension 
    name_file = name.gsub(/\.zip+$/,'')

    #asgino mediante random + fecha_actual el nuevo nombre del archivo
    final_name = "#{Date.today.strftime("%d%m%Y")}_#{name_file}_#{Random.rand(100..999)}.zip" 
    
    #valido que el content_type sea zip
    c_type = params[:file_resource][:name].content_type
   
    if c_type != "application/zip"
      flash[:notice] = "extension #{c_type} no valid, only .zip"
      redirect_to new_file_resource_path
      else
        #creo el objeto archivo
        @file_resource = FileResource.new(name: final_name)
        
        #subo el archivo mediante el modulo UploadFile
        upload_content(params[:file_resource][:name], final_name)

        path_file = Rails.root.join('app','files',final_name)
        f_file_se = final_name.gsub(/\.zip+$/,'')

        #hago la extraccion del archivo
        extract_zip(path_file,Rails.root.join('app','files', f_file_se))
        
        #recorro archivo de texto
        txt_file = Rails.root.join('app','files',"#{f_file_se}/pet.txt")
        pet_data = read_txt_file(txt_file) if File.exist?(txt_file)
        
        #construyo pet
        @pet = @file_resource.build_pet(name: pet_data[0], age: pet_data[1], color: pet_data[2])

        product_file = Rails.root.join('app','files',"#{f_file_se}/product.txt")
        product_data = read_product_file(product_file) if File.exist?(product_file)
        @product = @file_resource.products.build(product_data)
        
        respond_to do |format|
          if @file_resource.save
            #guardo archivo de texto
            @pet.save
            @product.each {|p| p.save}
            format.html { redirect_to file_resources_path, notice: 'File resource was successfully created.' }
            format.json { render :show, status: :created, location: @file_resource }
          else
            format.html { render :new }
            format.json { render json: @file_resource.errors, status: :unprocessable_entity }
          end
        end
      end
    end

  def download_file
    fname_path = Rails.root.join('app','files', @file_resource.name)
    send_file fname_path, filename: @file_resource.name, type: 'zip', disposition: 'attachment'
  end

  def pet_report
    pdf = render_to_string pdf: "pet_report.pdf",
          show_as_html: false,
          template: "file_resources/file_resource_pdf",
          encoding: "UTF-8"
          
    send_data pdf, filename: "pet_report_#{@file_resource.id}.pdf", type: "application/pdf", disposition: "attachment"
  end

  def product_report_xlsx
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"product_#{@file_resource.id}.xlsx\""}
    end
  end

  # DELETE /file_resources/1
  # DELETE /file_resources/1.json
  def destroy
    @file_resource.destroy
    respond_to do |format|
      format.html { redirect_to file_resources_url, notice: 'File resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_resource
      @file_resource = FileResource.find(params[:id])
      rescue => exception
        flash[:notice] = "#{params[:id]} File not found"
        redirect_to file_resources_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_resource_params
      params.require(:file_resource).permit(:name)
    end
end
