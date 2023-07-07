# Cleanup folder
Remove-Item -Recurse -Force "_assets"

# Recreate folder
New-Item -ItemType Directory -Path "_assets/website" -Force | Out-Null
New-Item -ItemType Directory -Path "_assets/ebook" -Force | Out-Null

# Compile JS
npx browserify src/js/core/index.js | npx uglifyjs -mc > "_assets/website/gitbook.js"
npx browserify src/js/theme/index.js | npx uglifyjs -mc > "_assets/website/theme.js"

# Compile Website CSS
npx lessc -clean-css src/less/website.less "_assets/website/style.css"

# Compile eBook CSS
npx lessc -clean-css src/less/ebook.less "_assets/ebook/ebook.css"
npx lessc -clean-css src/less/pdf.less "_assets/ebook/pdf.css"
npx lessc -clean-css src/less/mobi.less "_assets/ebook/mobi.css"
npx lessc -clean-css src/less/epub.less "_assets/ebook/epub.css"

# Copy fonts
New-Item -ItemType Directory -Path "_assets/website/fonts" -Force | Out-Null
Copy-Item -Recurse -Force "node_modules/font-awesome/fonts/" "_assets/website/fonts/fontawesome"

# Copy icons
New-Item -ItemType Directory -Path "_assets/website/images" -Force | Out-Null
Copy-Item -Force "node_modules/gitbook-logos/output/favicon.ico" "_assets/website/images/"
Copy-Item -Force "node_modules/gitbook-logos/output/apple-touch-icon-152.png" "_assets/website/images/apple-touch-icon-precomposed-152.png"
