import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue2'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue()
  ],
  resolve: {
    extensions: [
      '.vue',
      '.vue.erb',
      '.ts',
      '.js',
    ]
  }
})
