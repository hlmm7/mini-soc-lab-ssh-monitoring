# Incident Report – SSH Brute Force Simulation

## 1. Executive Summary
Simulación de intento de acceso no autorizado vía SSH en laboratorio virtualizado.

## 2. Lab Architecture
- Kali Linux: atacante
- Ubuntu Server: víctima
- Red interna: VirtualBox segmentada

## 3. Reconnaissance Phase
- Escaneo Nmap detecta puerto SSH abierto

## 4. Attack Simulation
- Intentos fallidos de autenticación SSH desde Kali

## 5. Detection Methodology
- Análisis de logs usando `journalctl`
- Script Bash automatizado para alertas

## 6. Evidence
- Captura de journalctl: `images/journal-logs.png`
- Script ejecutando detección: `images/detection-script.png`

## 7. Recommendations
- Usar autenticación por clave pública
- Implementar fail2ban
- Limitar acceso por firewall
