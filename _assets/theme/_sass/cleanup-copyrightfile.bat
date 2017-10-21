pandoc -f markdown_github-hard_line_breaks ^
       -t markdown_github-hard_line_breaks ^
	   --columns=80 ^
       --wrap=auto ^
       --normalize ^
       --reference-links ^
       --reference-location=document ^
       -o COPYRIGHT.md ^
          COPYRIGHT.md
