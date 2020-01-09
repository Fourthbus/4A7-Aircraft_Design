function dist = grt_cir(latlist, lonlist)
dist = 0;
for i = 1:(length(latlist)-1)
    dist = dist + distance(latlist(i),lonlist(i),latlist(i+1),lonlist(i+1));
end
dist = 2*pi*6371*dist/360