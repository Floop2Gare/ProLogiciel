@echo off
echo ========================================
echo    ERPNext - Demarrage automatique
echo ========================================
echo.

echo Demarrage de Docker...
docker-compose up -d

echo.
echo Attente du demarrage (5 minutes)...
timeout /t 300 /nobreak

echo.
echo ========================================
echo    ERPNext est pret !
echo ========================================
echo.
echo URL: http://localhost:8000
echo Utilisateur: Administrator
echo Mot de passe: admin
echo.
echo Appuyez sur une touche pour ouvrir dans le navigateur...
pause > nul

start http://localhost:8000

echo.
echo Pour arreter ERPNext, executez: docker-compose down
echo.
pause
