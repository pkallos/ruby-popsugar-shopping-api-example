class  PopsugarShoppingApp < Sinatra::Base
    get '/' do
        @products = []

        # a search has been performed
        if params[:s]
            client = Shopsense::API.new({'partner_id' => 'uid7849-6112293-28'})
            response = client.search(params[:s])
            raw_products = JSON.parse(response)["products"]
            puts raw_products.inspect

            # format the products a bit
            @products = raw_products.map! do |product|
                image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
                puts image.inspect
                {
                  'name' => product["name"],
                  'image' => image
                }
            end

            @search = params[:s]
        end
        erb :index
    end
end
