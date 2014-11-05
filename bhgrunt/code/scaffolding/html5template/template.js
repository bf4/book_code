/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
exports.description = 'Creates an HTML5 template with CSS and ' +
                      'JavaScript files.';

exports.notes = 'This project includes a default JavaScript and CSS file' + 
                'In addition, you can choose to include an optional ' + 
                'Gruntfile and some default CSS styles';

exports.template = function(grunt, init, done) {
  init.process({}, [
    // input prompts go here
    
    // Prompt for these values.
    init.prompt('name'  , 'AwesomeCo'),
    init.prompt('author', 'Max Power'),
    init.prompt('main'  , 'index.html'),
    {
      name: 'gruntfile',
      message: 'Do you want a Gruntfile?',
      default: 'Y/n',
      warning: 'If you want to be able to do cool stuff you should have one.'
    },
    {
      name: 'borderbox',
      message: 'Do you want to use the border-box styling in CSS?',
      default: 'Y/n'
    },
  ], function(err, props) {
    // processing section
    props.gruntfile = /y/i.test(props.gruntfile);
    props.borderbox = /y/i.test(props.borderbox);

    var files = init.filesToCopy(props);
    if(props.gruntfile){
      props.devDependencies = {
        'grunt': '~0.4.4'
      };
    }else{
      delete files['Gruntfile.js'];
    }
    init.copyAndProcess(files, props); 
    
    init.writePackageJSON('package.json', props);

    done();
  });

};
