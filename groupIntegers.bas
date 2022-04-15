#include "string.bi"
type group
	group_ (0 to 1000) as double
	count as integer=0
end type
const data_size=5
sub fill_group(g1 as group)
	dim n as integer
	g1.count=data_size
	for n=0 to data_size-1
		read g1.group_(n)
	next
end sub
sub add_(g1 as group,i as integer)
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
data -2.20D,-1,0,1.10D,2
dim n as integer
dim shared group1 as group
dim shared group2 as group
dim shared group3 as group
group1.count=0
group2.count=0
group3.count=0
fill_group(group1)
print "group:"
printGroup group1
for n=0 to group1.count-1
	if group1.group_(n)=int(group1.group_(n)) then
		add_(group2,group1.group_(n))
	else
		add_(group3,group1.group_(n))
	end if
next
print "group integer:"
printGroup group2
print "group not integer:"
printGroup group3


