gulp = require 'gulp'
sass = require 'gulp-sass'
connect = require 'gulp-connect'
watch = require 'gulp-watch'
concat = require 'gulp-concat'
gulp.task 'scss', ->
	gulp.src './scss/**/style.scss'
	.pipe sass errLogToConsole: on 
	.pipe gulp.dest './scss/'

gulp.task 'gather',['scss'],->
	gulp.src ['./bower_components/normalize_css/normalize.css','./bower_components/pure/grids-min.css', './scss/style.css']
	.pipe concat 'style.css'
	.pipe gulp.dest './css/'
	.pipe do connect.reload

gulp.task 'ind', ->
	gulp.src '*.html'
	.pipe do connect.reload

gulp.task 'connect', ->
	connect.server 
		# port: 1337
		root: './'
		livereload: on	

gulp.task 'build' ,['scss', 'gather',]

gulp.task 'watch', ->
	gulp.watch './scss/*.scss', ['scss', 'gather']
	gulp.watch 'index.html', ['ind']

gulp.task 'default', ['scss', 'gather', 'connect', 'watch']
