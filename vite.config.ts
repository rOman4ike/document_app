import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import RubyPlugin from 'vite-plugin-ruby'
import path from 'path'


export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue()
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'app/javascript'),
    },
    extensions: [
      '.vue',
      '.vue.erb',
      '.ts',
      '.js',
    ]
  }
})
