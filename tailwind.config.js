module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/views/**/*.turbo_stream.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*.html.erb'
  ],
  theme: {
    extend: {
      keyframes: {
        'slide-in': {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(0%)' }
        },
        'slide-out': {
          '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(100%)' }
        }
      },
      animation: {
        'slide-in': 'slide-in 0.3s ease-in',
        'slide-out': 'slide-out 0.3s ease-out'
      }
    }
  }
}
