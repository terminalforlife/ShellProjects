# DISCOVERED
I had a feeling you might open up this file. You might be wondering what it is. I guess I'll tell you.

This file is a culmination of a bunch of scripts or snippets of code, all which I've discovered (hence the name; see?) online somewhere out there. I will provide links to the source (location I discovered the code) whenever I can. Hope you pick up something cool; I'm sure I will!

## Function to Extract Archives

I've seen this before, but I have to put it here, because it's pretty cool.

Personally, I prefer to actually use and remember how to use those programs (rar, tar, zip, etc), otherwise I'm sure I'd be doing myself quite the disservice; what happens when I forget the code shown here, because I'm so used to the aliases? Yeah, that's a problem. Regardless, this is an awesome little function. I'm sure I'm guilty of this anyway. My .bash_aliases file in the miscellaneous repository is stuffed full of aliases which are kinda lazy.

```bash
extract () {
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)  tar xjf $1     ;;
         *.tar.gz)   tar xzf $1     ;;
         *.bz2)      bunzip2 $1     ;;
         *.rar)      rar x $1    ;;
         *.gz)    gunzip $1      ;;
         *.tar)      tar xf $1      ;;
         *.tbz2)     tar xjf $1     ;;
         *.tgz)      tar xzf $1     ;;
         *.zip)      unzip $1    ;;
         *.Z)     uncompress $1  ;;
         *)       echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
      echo "'$1' is not a valid file"
   fi
}
```

Source: https://pastebin.com/qjMC18aw

## Format the Built-in Time Command

I had no idea you could format that output; for the longest time (pun intended), I thought it was a bit ugly and also a waste of lines. I'm happy to see I can change it. I made use of this variable in my .bashrc file as well; I think it looks much better now!

```bash
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
```

Source: https://pastebin.com/qjMC18aw
