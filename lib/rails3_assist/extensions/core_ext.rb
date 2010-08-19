class Module
  def multi_alias name, options={}
    config_options = options[:options]
    options.each_pair do |original, aliases|
      next if original == :options 
      alias_methods name, original, [aliases].flatten, config_options
    end            
  end

  protected

  def alias_methods name, original, aliases, config_options
    aliases.each do |alias_name| 
      new_alias     = make_name(name, alias_name.to_s, config_options)
      original_name = make_name(name, original.to_s, config_options)
      alias_method new_alias, original_name if respond_to? original_name
    end
  end

  def make_name name, alias_name, config_options
    return alias_name.gsub(/X/, name.to_s) if alias_name =~ /X/
    case config_options
    when :after
      "#{alias_name}_#{name}"
    when :before
      "#{name}_#{alias_name}"
    end
  end
end