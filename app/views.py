from app import app

@app.route('/')
@app.route('/index')
def index():
  package = {'package_name': 'diagrams',
             'pagerank': 'rp_value_here'}
  return render_template('package_view.html',
                        package=package)

