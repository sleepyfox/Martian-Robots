NF == 3 { 
	x = $1;
	y = $2;
	f = $3;
}
/^[LRM]+$/ {
	d = "NESW";
	n = index(d,f);
	for (i = 1; i <= length; i++) {
		c = substr($0,i,1);
		if (c == "L") (n == 1) ? n=4: n--;
		if (c == "R") (n == 4) ? n=1: n++;
        if (c == "M") {
			if (n == 1) y++;
			if (n == 2) x++;
			if (n == 3) y--;
			if (n == 4) x--;
		}
	}
	print x," ",y," ",f;
}
