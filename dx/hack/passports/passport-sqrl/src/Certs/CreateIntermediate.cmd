@rem Creates an intermediate cert key pair signed with RootCert.
@rem
@rem IMPORTANT: For non-test purposes the key must be protected offline - do NOT
@rem check into source control, instead place on a USB stick that is kept offline
@rem except for rare cases where it is used to create intermediate certs.
@rem
@rem Usage: CreateIntermediate "Subject String" "BaseFilename"
@rem E.g.: CreateIntermediate "SQRL Test Site Intermediate" TestSiteIntermediate
@rem Expects RootCert.PrivateKey.pem and RootCert.Cert.pem generated by CreateRoot.cmd to be in the current directory.
@rem
@rem Derived from https://stackoverflow.com/questions/19665863/how-do-i-use-a-self-signed-certificate-for-a-https-node-js-server#24749608 and
@rem https://jamielinux.com/docs/openssl-certificate-authority/create-the-intermediate-pair.html
@rem
@rem Assumes OpenSSL-Win64 is installed from https://slproweb.com/products/Win32OpenSSL.html
@rem The "light" version is sufficient. Install binaries into the bin\ directory, not System32.

@rem https://stackoverflow.com/questions/94445/using-openssl-what-does-unable-to-write-random-state-mean
@rem https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 echo ERROR: You must run in cmd.exe running as administrator && exit /B 0

setlocal ENABLEDELAYEDEXPANSION

set OPENSSL_PATH=c:\OpenSSL-Win64\bin\openssl.exe
set SUBJECT=/C=US/ST=WA/L=Bothell/O=passport-sqrl/DX=%~1
set FILENAME_BASE=%~2
if "%FILENAME_BASE%"=="" set FILENAME_BASE=Intermediate

set ROOT_PRIV=RootCert.PrivateKey.pem
set ROOT_CERT=RootCert.Cert.pem
set INT_PRIV=%FILENAME_BASE%.PrivateKey.pem
set INT_CERT=%FILENAME_BASE%.Cert.pem

@rem Mid key length for intermediate key to last longer against brute force or quantum attack.
@echo.
%OPENSSL_PATH% genrsa -out %INT_PRIV% 3072
if ERRORLEVEL 1 echo genrsa failed with errorlevel %ERRORLEVEL% && exit /b 1

%OPENSSL_PATH% req -new -key %INT_PRIV% -out %FILENAME_BASE%.csr.pem -subj "%SUBJECT%" -config CertRequestTemplate.cnf -extensions v3_intermediate_ca_policy
if ERRORLEVEL 1 echo Creation of Cert Signing Request failed with errorlevel %ERRORLEVEL% && exit /b 1

@rem Use the root cert and CA database to sign the intermediate
@rem http://certificate.fyicenter.com/2115_OpenSSL_ca_Command_Options.html
@echo.
%OPENSSL_PATH% ca -verbose -config CertRequestTemplate.cnf -extensions v3_intermediate_ca_policy -in %FILENAME_BASE%.csr.pem -cert %ROOT_CERT% -keyfile %ROOT_PRIV% -out %INT_CERT% -outdir . -days 3650 -batch
if ERRORLEVEL 1 echo Signing of intermediate public cert with root certificate authority cert and key failed with errorlevel %ERRORLEVEL% && exit /b 1

@rem Verify our result by ensuring the intermediate chains to the root.
@echo.
%OPENSSL_PATH% verify -verbose -CAfile %ROOT_CERT% %INT_CERT%
if ERRORLEVEL 1 echo Validation of intermediate cert failed with errorlevel %ERRORLEVEL% && exit /b 1

del %FILENAME_BASE%.csr.pem

echo Wrote private key into %INT_PRIV% and cert into %INT_CERT%

exit /b 0
