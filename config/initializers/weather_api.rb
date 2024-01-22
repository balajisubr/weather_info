api_info = YAML.load_file("#{Rails.root}/config/weather_api.yml")
WEATHER_API_KEY = api_info['api_key']
