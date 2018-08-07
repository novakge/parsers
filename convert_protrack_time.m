% function is used to convert protrack time format (dd-MM-yyyy-hh:mm:ss) for a more usable numeric format
function startdate = convert_protrack_time(inputdate)

startyear = str2num(char(extractBetween(inputdate,5,8)));
startmonth = str2num(char(extractBetween(inputdate,3,4)));
startday = str2num(char(extractBetween(inputdate,1,2)));
starthour = str2num(char(extractBetween(inputdate,9,10)));
startminute = str2num(char(extractBetween(inputdate,11,12)));
startsec = 0; % ignore, even if defined, not significant but needed

startdate = datenum(startyear,startmonth,startday,starthour,startminute,startsec); % also take hours into account as fractions

end