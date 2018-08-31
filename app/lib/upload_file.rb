require 'zip'
module UploadFile

  def upload_content(file_upload, rename_f)
    f_path = Rails.root.join('app','files',file_upload.original_filename)
    File.open(f_path, 'wb') do |file|
      file.write(file_upload.read)
      File.rename(f_path, Rails.root.join('app','files',rename_f))
    end
  end

  def extract_zip(file, destination)
    FileUtils.mkdir_p(destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

  def delete_file(file)
    f_name = file.gsub(/\.zip+$/,'')
    f_path = Rails.root.join('app','files',"#{f_name}*")
    FileUtils.rm_rf(Dir.glob(f_path))
  end

  def read_txt_file(file)
    lines = File.readlines(file)
    aux = []
    lines.drop(1).each do |x|
      x = x.split("|")[1].strip
      aux.push(x)
    end
    aux
  end

  def read_product_file(file) 
    lines = File.readlines(file).drop(1)
    lines.map do |p|
      data = p.split(";")
      {
        code: data[0],
        descripcion: data[1],
        quantity: data[2],
        valor: data[3].strip
      }
    end
  end
end
