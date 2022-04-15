#include "string.bi"
const xd=300
const yd=200
const esc=27
const data_size=7
type group
	group_ (0 to 1000) as double
	count as integer=0
end type
sub fill_group(g1 as group)
	dim n as integer
	g1.count=data_size
	for n=0 to data_size-1
		read g1.group_(n)
	next
end sub
sub add_(g1 as group,i as double)
	if g1.count<999 then
		g1.group_(g1.count)=i
		g1.count=g1.count+1
	end if
end sub
sub printGroup(g1 as group)
	dim n as integer
	for n=0 to g1.count-1
		print format(g1.group_(n),"0.00");
		if n<> g1.count-1 then print " , ";
	next
	print
end sub
function max(g1 as group) as double
	dim n as integer
	dim m as double=0
	if g1.count > 0 then 
		m=g1.group_(0)
		for n=0 to g1.count-1
			if g1.group_(n)>m then m=g1.group_(n)
		next
	end if 
	return m
end function
function min(g1 as group) as double
	dim n as integer
	dim m as double=0
	if g1.count > 0 then 
		m=g1.group_(0)
		for n=0 to g1.count-1
			if g1.group_(n)<m then m=g1.group_(n)
		next
	end if 
	return m
end function
function med(g1 as group) as double
	dim n as integer
	dim m as double=0
	dim r as double=0
	if g1.count > 0 then 
		m=0
		for n=0 to g1.count-1
			m=m+g1.group_(n)
		next
		if m<>0 then r=m/g1.count
	end if 
	return r
end function
function sum(g1 as group) as double
	dim n as integer
	dim m as double=0
	dim r as double=0
	if g1.count > 0 then 
		m=0
		for n=0 to g1.count-1
			m=m+g1.group_(n)
		next
	end if 
	return m
end function
sub display(xx as group,yy as group)
	dim k as string
	dim n as integer
	screenres xd,yd,8
	line (0,0)-(xd,yd),0,bf
	line (0,yd/2)-(xd,yd/2),7
	line (xd/2,0)-(xd/2,yd),7
	if xx.count<> yy.count or xx.count < 1 then
		goto escapes
	end if
	for n=0 to xx.count-1
		circle ((xd/2)+xx.group_(n)*5,(yd/2)+yy.group_(n)*5),3,7,,,,f
	next
	while true
		k=inkey()
		if k=chr(esc)then goto escapes
	wend 
	escapes:
end sub
sub savedatas(g1 as group,names as string)
	dim n as integer
	open names for output as #1
	for n=0 to g1.count-1
		print #1,trim(str(g1.group_(n)))
	next
	close #1
end sub
sub loaddatas(g1 as group,names as string)
	dim n as integer
	dim d as double
	dim s as string
	open names for input as #1
	while not eof(1)
		line input #1,s
		d=val(s)
		add_ g1,d
	wend
	close #1
end sub
function percent(value as double,per as double)as double
	dim d as double 
	d=value/100*per
	return d
end function
sub reverse(g1 as group)
	dim n as integer
	dim g2 as group
	for n=0 to g1.count-1
		g2.group_(n)=g1.group_(n)
	next
	g2.count=g1.count
	for n=g1.count-1 to 0 step -1
		g1.group_(g1.count-1-n)=g2.group_(n)
	next
end sub
sub addsort(g1 as group,i as double)
	dim n as integer
	dim d as double
	dim dd as double
	d=i
	if g1.count<999 then
		if g1.count>0 then
			for n=0 to g1.count-1
				if g1.group_(n)>d then 
					dd=g1.group_(n)
					g1.group_(n)=d
					d=dd
				end if
			next
			g1.group_(g1.count)=d
			g1.count=g1.count+1
		else
			g1.group_(g1.count)=d
			g1.count=g1.count+1
		end if
	end if
end sub
sub fillread(g1 as group)
	dim n as integer
	dim d as double
	for n=0 to data_size-1
		read d
		addsort g1,d
	next
end sub
sub copyGroup(g1 as group,g2 as group)
	dim n as integer
	for n=0 to g1.count-1
		g2.group_(n)=g1.group_(n)
	next
	g2.count=g1.count
end sub
sub order(g1 as group)
	dim n as integer
	dim g2 as group
	for n=0 to g1.count-1
		g2.group_(n)=g1.group_(n)
	next
	g2.count=g1.count
	g1.count=0
	for n=0 to g2.count-1
		addsort g1,g2.group_(n)
	next
end sub
sub bar(g1 as group)
	dim k as string
	dim n as integer
	screenres xd,yd,8
	line (0,0)-(xd,yd),0,bf
	if g1.count>xd/2-2 then
		for n=0 to xd/2-2
			line (n*2,yd-20)-(n*2,yd-20-abs(g1.group_(n))),7
		next
	else
		for n=0 to g1.count-1
			line (n*(xd/(g1.count-1)),yd-20)-((n+1)*(xd/(g1.count-1))-1,yd-20-abs(g1.group_(n))),7,bf
		next
	end if
	while true
		k=inkey()
		if k=chr(esc)then goto escapes
	wend 
	escapes:
end sub
sub copyn(g1 as group,g2 as group,count as integer)
	dim n as integer
	dim i as integer
	i=g1.count-1
	if i>count then i=count
	for n=0 to i
		g2.group_(n)=g1.group_(n)
	next
	g2.count=i
end sub
data 12,7,5,3,9,10,8
data 12,7,5,3,9,10,8
dim n as integer
dim g1 as group
dim g2 as group
randomize timer()
for n=0 to 10
	add_ g1,int(rnd()*98)
next 
printGroup g1
copyn g1,g2,5
printGroup g2

