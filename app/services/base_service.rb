class BaseService
  attr_reader :errors

  def call
    raise NotImplementedError
  end

  def success?
    @errors ||= []
    @errors.blank?
  end

  def error?
    !success?
  end

  def error_messages
    @errors ||= []
    return [] if @errors.blank?

    @errors.map do |error|
      if error.is_a?(ActiveModel::Errors)
        error.full_messages
      else
        error.to_s
      end
    end.flatten
  end

  def add_errors(errs)
    @errors ||= []
    errs.each { |e| add_error(e) }
  end

  def add_error(error)
    @errors ||= []
    if error.is_a?(StandardError)
      @errors << error
    elsif error.is_a?(ActiveModel::Errors)
      @errors << error
    elsif error.is_a?(Array)
      error.each { |err| add_error(err) }
    else
      @errors << StandardError.new(error)
    end
  end
end