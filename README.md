# 😎 Obsidian Hub V2

Obsidian Hub V2 é um **framework de UI em Lua para Roblox**, focado em um visual **Obsidian agressivo** (escuro, minimalista e tech), com sistema de **tabs, sliders, presets, animações e estrutura modular**.

> ⚠️ Este projeto é um **framework visual**.  
> Ele **não contém cheats/exploits por padrão**. Todas as funções sensíveis são apenas **callbacks vazios**, prontas para integração.

---

## ✨ Features

- 🎨 UI estilo **Obsidian (Dark / Tech)**
- 🧭 Tabs laterais organizadas
- 🎛️ Sliders configuráveis (até 1000)
- 💾 Sistema de presets (estrutura)
- 🌈 RGB discreto (accent)
- ⏳ Loading screen
- 🎬 Animações suaves
- ⚙️ Arquitetura modular
- ⌨️ Tecla para abrir/fechar o hub
- 📦 Compatível com `loadstring(game:HttpGet())()`

---

## 📁 Estrutura do Projeto

```text
ObsidianHub/
 ├─ main.lua        # Loader principal (entry point)
 ├─ ui.lua          # Interface, tabs e animações
 ├─ config.lua      # Tema, presets, estados
 └─ modules/
     ├─ fly.lua
     ├─ speed.lua
     └─ teleport.lua
