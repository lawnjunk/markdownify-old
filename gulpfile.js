'use strict';

const gulp = require('gulp');
const run = require('gulp-run');

const paths = ['lib/**/*.sh', 'main.sh'];

gulp.task('render', function(){
  console.log('first');
  run('./render.sh').exec()
});

gulp.task('watch', function(){
  gulp.watch(paths, ['build']);
});

gulp.task('build', ['render']);
gulp.task('default', ['build']);
