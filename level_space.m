MM = 50;
nbins = 30;
tol_cnt = zeros(MM,nbins);
tol_centers = zeros(MM,nbins);
tol_lev_sp = zeros(MM,1);
for ii = 1:MM
    diag_schroding;
    lev = diag(d);
    lev = sort(lev);
    min_ind = find(lev >= 0.0,1);
    max_ind = find(lev >= 0.4,1);
    lev = lev(min_ind:max_ind);
    lev_sp = diff(lev);
    tol_lev_sp(ii) = mean(lev_sp);
    [cnt,centers] = hist(lev_sp,nbins);
    tol_cnt(ii,:) = cnt;
    tol_centers(ii,:) = centers;
end
mean_cnt = sum(tol_cnt)/MM;
mean_centers = sum(tol_centers)/MM;

mean_lev_sp = mean(tol_lev_sp);

mean_centers = mean_centers/mean_lev_sp;
tol = trapz(mean_centers,mean_cnt);
plot(mean_centers,mean_cnt/tol,'o')
hold on
s = 0:0.05:max(mean_centers);
plot(s,exp(-s),'r-',s,pi/2*s.*exp(-s.^2*pi/4),'g--')
%axis([0 5 0 1])
%plot(s,exp(-s),'r-',s,2^18/(3^6*pi^3)*s.^4.*exp(-s.^2*64/(9*pi)),'g--')