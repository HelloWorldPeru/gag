class Post < ActiveRecord::Base
  belongs_to :user
  FOTOS = File.join Rails.root, 'public', 'photo_store'
  validates_presence_of :title, :extension
  after_save :save_photo

  #Campo logico
  def photo=(file_data)
    #Entra cuando es falso (campo de foto esta en blanco?)
    unless file_data.blank?
      @file_data = file_data #file_data contiene el nombre del archivo
      self.extension = file_data.original_filename.split('.').last.downcase #Obtenemos su extension
    end
  end

  def photo_filename
    #Ruta completa + nombre de la foto
    File.join FOTOS, "#{id}.#{extension}"
  end

  def photo_path
    #Ruta desde public
    "/photo_store/#{id}.#{extension}"
  end
  def has_photo?
    File.exists? photo_filename
  end
  private #Indica que los metodos definidos solo pueden ser accedidos a traves del modelo
  def save_photo
    if @file_data
      FileUtils.mkdir_p FOTOS #Crea la carpeta en caso no exista
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      @file_data = nil
    end
  end
end
