module ResultFormatters
  
  def to_xml
    
  end
  
  def to_json
    
  end
  
  def to_hash
    
  end  
  
  def to_string
    
  end
    

  def to_file(format_symbol, full_file_path)
    File.open.write()
    result=send(format_symbol)
  end

end