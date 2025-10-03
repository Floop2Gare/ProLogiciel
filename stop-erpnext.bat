@echo off
echo ========================================
echo    Arret d'ERPNext
echo ========================================
echo.

echo Arret des conteneurs Docker...
docker-compose down

echo.
echo ERPNext arrete avec succes !
echo.
pause
