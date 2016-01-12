module Wayward

  class Blueprint < OpenStruct

    def self.where conditions
      begin
        search_endpoint = get_endpoint + '?' + URI.encode_www_form(conditions)
        req = Net::HTTP::Get.new(search_endpoint, initheader = {'Content-Type' =>'application/json'})
        req['email'] = Wayward.configuration.email
        req['secret'] = Wayward.configuration.secret
        http = Net::HTTP.new('www.wayward.com.br').start {|http| http.request(req) }
        response = JSON.parse(http.body, symbolize_names: true)
      rescue Exception => ex
        response = []
      end
      response.map {|r| new(r)}
    end

    def save
      id.nil? ? create : update
    end

    private

      def create
        begin
          req = Net::HTTP::Post.new(post_endpoint, initheader = {'Content-Type' =>'application/json'})
          req['email'] = Wayward.configuration.email
          req['secret'] = Wayward.configuration.secret
          req.set_form_data(to_h)
          http = Net::HTTP.new('www.wayward.com.br').start {|http| http.request(req) }
          response = JSON.parse(http.body.force_encoding('UTF-8'), symbolize_names: true)
        rescue Exception => ex
          response = {errors: [ex.message]}
        end
        self.errors = response[:errors]
        self.id = response[:id] if response[:id]
        !self.errors.any?
      end

      def update
        begin
          req = Net::HTTP::Post.new(put_endpoint, initheader = {'Content-Type' =>'application/json'})
          req['email'] = Wayward.configuration.email
          req['secret'] = Wayward.configuration.secret
          req.set_form_data(to_h.merge(_method: 'PUT'))
          http = Net::HTTP.new('www.wayward.com.br').start {|http| http.request(req) }
          response = JSON.parse(http.body.force_encoding('UTF-8'), symbolize_names: true)
        rescue Exception => ex
          response = {errors: [ex.message]}
        end
        self.errors = response[:errors]
        !self.errors.any?
      end

      def self.get_endpoint
        "/api/#{Wayward.configuration.api_version}/projects/#{Wayward.configuration.project}/blueprints/#{to_s.split('::').last}/forms"
      end

      def post_endpoint
        self.class.get_endpoint
      end

      def put_endpoint
        self.class.get_endpoint + "/#{id}"
      end

  end

end
