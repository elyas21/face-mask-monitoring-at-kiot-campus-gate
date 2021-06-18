from flask import render_template, request, Blueprint


main = Blueprint('main', __name__)

posts = []

@main.route("/")
@main.route("/home")
def home():
    return render_template('home.html', posts=posts)


@main.route("/about")
def about():
    return render_template('about.html', title='About')