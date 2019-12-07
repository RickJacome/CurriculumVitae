clear all; clc; close all
load('SGAHalf.mat'); load('SGT.mat');
Time = SplitGravelTime(1:numel(SplitGravelTime)/2);
SGA = SGAHalf;
fftf(Time, SGAHalf, [], 20);
function [X, f, y, y2] = fftf(t, x, varargin)
%% Definitions
Fs=1/(t(2)-t(1)); %sampling freq
N=length(x);
Nfft=2^nextpow2(N);
f=Fs/2*linspace(0,1,1+Nfft/2); % create freqs vector
cutoff_freq=Fs/8;
my_freqs=[];
if nargin>2,
    cutoff_freq=varargin{1};
end
if nargin>3,
    my_freqs=varargin{2};
end
%% main
y=fft(x,Nfft)/N; % perform fft transform
y2=filterfft(f, y, cutoff_freq, my_freqs); % filter amplitudes
X=ifft(y2); % inverse transform
X=X(1:N)/max(X);
ind1 = find(y2(1:1+Nfft/2)); % get the nonzero elements in y2
nf1 = length(ind1); % count nonzero elements
%% display
figname = 'fftf - FFT at work';
ifig = findobj('type', 'figure', 'name', figname);
if isempty(ifig),
    ifig = figure('name', figname); % on my machine: ..., 'position', [360   120   600   800]);
end
figure(ifig);
% first plot
subplot(3,1,1); plot(t*1e6,x)
xlabel('uSec'); ylabel('Acceleration (Gs)')
axis tight; title('Raw Longitudinal Vehicle Acceleration')
%second plot
subplot(3,1,2)
yplot=abs(y(1:1+Nfft/2));
yplot=yplot/max(yplot);
semilogy(f*1e-6, yplot, f(ind1)*1e-6, yplot(ind1), '.r');
xlabel('MHz'); ylabel('Amplitude')
title('Fast Fourier Transform Amplitudes')
legend('full spectrum', 'selected frequencies')
% third plot
subplot(3,1,3); plot(t*1e6,X); xlabel('uSec')
ylabel('Acceleration (Gs)')
if isempty(cutoff_freq),
    scutoff='No cutoff.';
else
    scutoff=sprintf('Cutoff = %g [Mhz]', cutoff_freq/1e6);
end
stitle3=sprintf('Reconstructed signal with %d selected frequencies; %s', nf1, scutoff);
title(stitle3); axis tight
return

function y2=filterfft(f, y, cutoff, wins)
nf=length(f);
ny=length(y);
if ~(ny/2+1 == nf),
    disp('unexpected dimensions of input vectors!')
    y2=-1;
    return
end
% cutoff filter
y2=zeros(1,ny);
if ~isempty(cutoff)
    ind1=find(f<=cutoff);
    y2(ind1) = y(ind1); % insert required elements
else
    y2=y;
end
% dominant freqs filter
if ~isempty(wins),
    temp=abs(y2(1:nf));
    y2=zeros(1,ny);
    for k=1:wins,   % number of freqs that I want
        [tmax, tmaxi]=max(temp);
        y2(tmaxi) = y(tmaxi); % insert required element
        temp(tmaxi)=0; % eliminate candidate from list
    end
end
% create a conjugate symmetric vector of amplitudes
for k=nf+1:ny,
    y2(k) = conj(y2(mod(ny-k+1,ny)+1)); % formula from the help of ifft
end
return
end
end