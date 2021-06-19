from maskControl import create_app

web_app = create_app()

if __name__ == '__main__':
    web_app.run(debug=True, threaded=True)