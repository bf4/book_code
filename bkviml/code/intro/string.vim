"START:quoteNewlines
"I sing the Sofa. I who lately sang\nTruth, Hope, and Charity..."
'I sing the Sofa. I who lately sang\nTruth, Hope, and Charity...'
"END:quoteNewlines

"START:echoNewlines
:echo "I sing the Sofa. I who lately sang\nTruth, Hope, and Charity..."
" → I sing the Sofa. I who lately sang
    Truth, Hope, and Charity...

:echo 'I sing the Sofa. I who lately sang\nTruth, Hope, and Charity...'
" → I sing the Sofa. I who lately sang\nTruth, Hope, and Charity...
"END:echoNewlines

"START:firstComments
:echo "I sing the Sofa. I who lately sang"
" Truth, Hope, and Charity, and touch'd with awe
:echo "The solemn chords..."
"END:firstComments

"START:secondComment
:ls " The command to list all buffers.
"END:secondComment
