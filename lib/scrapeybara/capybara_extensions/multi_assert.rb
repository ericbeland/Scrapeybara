module CapybaraExtensions
  module MultiAssert
  # we add our multiple assertions by wrapping method_missing. 
  # longer term, wrapping a defined set of functions with alias_method_chain is speedier
    def method_missing(meth, *args, &block)      
      matches = /assert_(has_.*)/.match(meth.to_s)
      if matches and matches.length > 0
        function = matches[1]
        arg1 = [args.shift].flatten
        arg1.each {|item| assert(send(function, item, *args), "failed on assertion #{function} #{item} \n#{caller[2]}") }            
      else
        super
      end
    end 
    
  end
end