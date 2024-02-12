# frozen_string_literal: true

class BaseModel
  def to_h
    instance_variables.each_with_object({}) do |var, hash|
      value = instance_variable_get(var)

      hash[var.to_s.delete("@").to_sym] = value.is_a?(Date) ? value.to_s : value
    end
  end
end
