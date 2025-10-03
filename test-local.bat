@echo off
echo ========================================
echo    Test ERPNext Local - Windows
echo ========================================
echo.

echo Verification de Docker...
docker --version
if %errorlevel% neq 0 (
    echo ERREUR: Docker n'est pas installe
    echo Veuillez installer Docker Desktop depuis docker.com
    pause
    exit /b 1
)

echo.
echo Docker detecte ! Demarrage du test...
echo.

echo Construction de l'image Docker...
docker build -t erpnext-test .

echo.
echo Demarrage d'ERPNext...
echo URL: http://localhost:8000
echo Utilisateur: Administrator
echo Mot de passe: admin
echo.

docker run -p 8000:8000 erpnext-test

echo.
echo Test termine !
pause
