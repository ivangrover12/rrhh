let mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js('resources/assets/js/app.js', 'public/js')
   .sass('resources/assets/sass/app.scss', 'public/css')
   .styles([
       'resources/assets/css/payroll-print.css'
    ], 'public/css/all.css')
   .copy('resources/assets/img', 'public/images')
   .copy('resources/assets/css/swich.css', 'public/css')
   .copy('resources/assets/css/datatables-fixedcolumns.min.css', 'public/css')
   .copy('resources/assets/css/responsive.dataTables.min.css', 'public/css')
   .copy('resources/assets/js/dataTables.responsive.js', 'public/js');
