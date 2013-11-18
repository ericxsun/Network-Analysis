function mail2phone(smtp_server, account, password, dst_addr, subject, ...
                    content)
%MAIL2PHONE Send an email to the given mail account.
%   MAIL2PHONE(smtp_server, account, password, dst_addr, subject, content) 
%   sends an email.
%
%   Algorithm:
%
%   Note:
%
%   Example:
%       MAIL2PHONE('smtp.139.com', account, password, 'test', 'test')
%
%   Ref:
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25 2012$
%

%--------------------------------------------------------------------------

if nargin < 4
    subject = '';
    content = '';
end
if nargin < 5
    content = '';
end

from_mailAddr = account;
password      = password';

setpref('Internet', 'E_mail',        from_mailAddr);
setpref('Internet', 'SMTP_Server',   smtp_server);
setpref('Internet', 'SMTP_Username', from_mailAddr);
setpref('Internet', 'SMTP_Password', password);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth', 'true');
% props.setProperty('mail.smtp.socketFactory.class', ...
%                   'javax.net.ssl.SSLSocketFactory');
% props.setProperty('mail.smtp.socketFactory.prot', '465');

fprintf('send email to %m\n', account);

sendmail(dst_addr, subject, content);

fprintf('\n');

%--------------------------------------------------------------------------
end