#
# Download remote images for quicker loading times
#

imgcachedir="img/cache"

for post in $(find . -name "*.html"); do
        # Extract image urls and download them to the images folder
        # Then update all image urls in the posts
        for imageurl in $(grep -oP '<img\s+src="\K[^"]+' $post | grep 'http'); do
                image_target_filename="$imgcachedir/$(echo $imageurl | sed 's,/,_,g;s/,/_/g')"

                wget --continue $imageurl -O $image_target_filename

                sed -i "s%$imageurl%/$image_target_filename%g" $post
        done
done
