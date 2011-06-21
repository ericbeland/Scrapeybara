module Params  

  require 'csv'

  class Parameters
    attr_accessor :selection_method
  
    def initialize(csv_string, options={})     
      logger = options[:logger]
      options = {:selection_method => :use_all_records}.merge(options)
      @databank_type = options[:selection_method]
      record_array = csv_string.split("\n")
      @headers = record_array.delete_at(0).split(',')
      @records = record_array
      logger.info("Records: #{@records}") if logger
    end  
   
    # gets a record for the given identifier
    def get_row(user_number)   
      record = nil
      case @databank_type      
        when :use_all_records
          mutex = Mutex.new
          mutex.synchronize { record = @records.next }
        when :use_same_record
          if user_id > (@records.length)
            record_num = (user_number % @records.length) - 1
          else
            record_num = user_number - 1 # user_number (different threads) are 1 based, records 
          end               
       record=@records[record_num]
      end
      CSV::Row.new(@headers, record.split(','))    
    end  
  
    # exceptions should be handled at the next level up...
    def set_variables_in_binding(identifier, binding_obj)
      row = get_row(identifier)
      msg = []
      row.headers.each do |header|
        msg << "#{header}=#{row.field(header)}"
        binding_obj.instance_variable_set("@#{header}".to_sym, row.field(header))       
      end
      logger.info("set parameter vars:#{msg.join(',')} for #{identifier}") if logger
      row
    end
   
  end
  
end