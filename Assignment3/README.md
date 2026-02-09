In this project the objective was to work with several images and use methods such as
morphological operations, laplacian and median filters to transform images and compare the
results. 

TEST RESULTS

2.1 Morphological filters
For the first part of the assignment, morphological filters had to be identified that
transofrmed the original image (salt&pepper noise) into the other two. The same filters had to be
applied for the given input image to get the same result. In the Figure 1, the output results from
my program are presented, that resemble the requested output result in the assignment. For the
image (a) the matlab function imopen was used. The presence of black dots on the figure “2”
prompted me to such conclusion, but for the image (b) the opening operationg was followed by
closure, again, in this case because the image did not have black dots inside and white outside.
The size of the structural element chosen was based on the requested result – I was trying to
get images to be looking as close as possible to those in the example.

2.2 Fingerprint Image
For the fingerprint image two filters were, Figure 1 shows (a) – result after applying
morphological filters and (b) – result after applying median filter. In my opinion, in this case,
morphological filters performed better than median. In the image (b) there still can be seen some
leftover noise around the fignerpint, but, on the contrary to morphological filters, the fingerprint
itself is preserved better. Taking a look into the very center fo the fignerprint image (a) exhibits
some gaps, whereas everything stays consisted in the image (b). This example shows that
morphological filter works really well when there are isolated “noise pieces”, while median filter
priotirizes preserving details and having a little noise. Even though, I personally prefer the result
of morphological filter, it might be tricky, because of those center details. For instance, if any little
gaps that appeared using morphological filter would cause data loss and if used as biometrics,
that would be enough.

2.3 Laplacian for image enhancement
Figure 1 presents the original image (a), and enhanceed image(b) used Laplacian
filtering. This was the most exciting piece of assignment for me to work on, because I still am
amazed by how this filter can enhance the image. First, I started by applying the laplacian filter,
which got me a very good definition of edges, and to get the enhanced image I subtracted the
one I applied Laplacian filter to from the original image. Obviously, the shadows are not present
like in the original image, but the definition of edges and craters looks extraordinary, comparing
to the original. I think this filter is good for a lot of tasks, when there is a need for standing-out
details.
