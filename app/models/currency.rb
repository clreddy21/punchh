class Currency

  @@base_url = 'https://api.exchangeratesapi.io'

  def self.list
    res_hash = eval(make_request('/latest'))
    currencies = [res_hash[:base]]

    res_hash[:rates].each do |currency|
      currencies << "#{currency[0]}"
    end
    currencies
  end

  def self.get_data(params)
    start_at, end_at = params[:date_range].split(' - ')
    symbols = params[:currencies]

    result = make_request('/history',start_at: start_at, end_at: end_at, symbols: symbols)
  end

  protected

  def self.make_request(path, options={})
    url  = @@base_url + path
    payload = options.present? ? "?start_at=#{options[:start_at]}&end_at=#{options[:end_at]}&base=#{options[:symbols][0]}&symbols=#{options[:symbols][1]}" : ''
    url += payload

    result = get_result(url)
    format_result(result, options)
  end

  
  def self.get_result(url)
    RestClient::Request.execute(
        method: :get,
        url: url,
        headers: {
            'Content-Type' => "application/json"
        }
    )
  end


  def self.format_result(result, options)
    if options.present?
      puts result.inspect
      result = eval(result)[:rates].sort_by { |k,_| Date.strptime(k.to_s, "%Y-%m-%d") }
      result = Hash[result.collect { |result| [result[0], result[1]] } ]

      keys = result.keys.map{ |date| date.to_s}
      values = result.values.map{ |hash| hash.values}.flatten
      [keys: keys, values: values]
    else
      result
    end
  end
end