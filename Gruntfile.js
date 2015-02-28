/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    // Task configuration.
	jison: {
		options: {
			moduleName:"CQL_Parser"
		},
		my_parser : {
			files: { 'cql.js': 'cql.jison' }
		}
	}
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-jison');

  // Default task.
  grunt.registerTask('default', ['jison']);
  
};
