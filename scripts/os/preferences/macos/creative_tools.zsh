#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h} \
    source "../../utils.zsh"

print_in_purple "\n   Creative and Generative AI Tools\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Image Creation and Editing
brew_install "adobe-creative-cloud" "Installing Adobe Creative Cloud" true

brew_install "figma" "Installing Figma" true

brew_install "sketch" "Installing Sketch" true

brew_install "affinity-designer" "Installing Affinity Designer" true

brew_install "affinity-photo" "Installing Affinity Photo" true

brew_install "blender" "Installing Blender" true

# Generative AI Image Tools
brew_install "stable-diffusion-ui" "Installing Stable Diffusion UI" true

brew_install "diffusionbee" "Installing DiffusionBee" true

brew_install "invoke-ai" "Installing Invoke AI" true

brew_install "comfyui" "Installing ComfyUI" true

brew_install "fooocus" "Installing Fooocus" true

brew_install "auto-photoshop" "Installing Auto Photoshop" true

# Video Creation and Editing
brew_install "davinci-resolve" "Installing DaVinci Resolve" true

brew_install "final-cut-pro" "Installing Final Cut Pro" true

brew_install "after-effects" "Installing After Effects" true

brew_install "premiere-pro" "Installing Premiere Pro" true

brew_install "obs" "Installing OBS Studio" true

# Generative AI Video Tools
brew_install "runway" "Installing Runway" true

brew_install "d-id-studio" "Installing D-ID Studio" true

brew_install "synthesia" "Installing Synthesia" true

brew_install "descript" "Installing Descript" true

brew_install "wonder-studio" "Installing Wonder Studio" true

# Audio Creation and Editing
brew_install "logic-pro" "Installing Logic Pro" true

brew_install "ableton-live" "Installing Ableton Live" true

brew_install "audacity" "Installing Audacity" true

brew_install "garageband" "Installing GarageBand" true

# Generative AI Audio Tools
brew_install "murf-studio" "Installing Murf Studio" true

brew_install "elevenlabs" "Installing ElevenLabs" true

brew_install "soundraw" "Installing Soundraw" true

brew_install "musicgen" "Installing MusicGen" true

brew_install "audiogen" "Installing AudioGen" true

# 3D Modeling and Animation
brew_install "blender" "Installing Blender" true

brew_install "maya" "Installing Maya" true

brew_install "cinema-4d" "Installing Cinema 4D" true

brew_install "houdini" "Installing Houdini" true

brew_install "zbrush" "Installing ZBrush" true

brew_install "modo" "Installing Modo" true

brew_install "rhino" "Installing Rhino" true

brew_install "substance-3d-painter" "Installing Substance 3D Painter" true

brew_install "substance-3d-designer" "Installing Substance 3D Designer" true

brew_install "substance-3d-sampler" "Installing Substance 3D Sampler" true

# 3D Scanning and Photogrammetry
brew_install "reality-capture" "Installing Reality Capture" true

brew_install "agisoft-metashape" "Installing Agisoft Metashape" true

brew_install "meshroom" "Installing Meshroom" true

brew_install "scan-to-cad" "Installing Scan to CAD" true

brew_install "artec-studio" "Installing Artec Studio" true

# 3D Printing and Slicing
brew_install "ultimaker-cura" "Installing Ultimaker Cura" true

brew_install "prusa-slicer" "Installing Prusa Slicer" true

brew_install "simplify3d" "Installing Simplify3D" true

brew_install "makerbot-print" "Installing MakerBot Print" true

brew_install "raise3d-ideamaker" "Installing ideaMaker" true

# CAD and Engineering
brew_install "fusion360" "Installing Fusion 360" true

brew_install "solidworks" "Installing SOLIDWORKS" true

brew_install "onshape" "Installing Onshape" true

brew_install "freecad" "Installing FreeCAD" true

brew_install "openscad" "Installing OpenSCAD" true

# 3D Game Development
brew_install "unity-hub" "Installing Unity Hub" true

brew_install "unreal-engine" "Installing Unreal Engine" true

brew_install "godot" "Installing Godot" true

brew_install "cryengine" "Installing CryEngine" true

brew_install "lumberyard" "Installing Lumberyard" true

# 3D Visualization and Rendering
brew_install "v-ray" "Installing V-Ray" true

brew_install "corona-renderer" "Installing Corona Renderer" true

brew_install "octane-render" "Installing Octane Render" true

brew_install "redshift-render" "Installing Redshift" true

brew_install "arnold-renderer" "Installing Arnold" true

# Generative AI 3D Tools
brew_install "nvidia-omniverse" "Installing NVIDIA Omniverse" true

brew_install "point-e" "Installing Point-E" true

brew_install "get3d" "Installing GET3D" true

brew_install "dreamfusion" "Installing DreamFusion" true

brew_install "shap-e" "Installing Shap-E" true

brew_install "magic3d" "Installing Magic3D" true

brew_install "instant-3d" "Installing Instant 3D" true

brew_install "nerf-studio" "Installing NeRF Studio" true

brew_install "gaussian-splatting" "Installing Gaussian Splatting" true

brew_install "threestudio" "Installing ThreeStudio" true

# 3D Asset Management
brew_install "quixel-bridge" "Installing Quixel Bridge" true

brew_install "sketchfab" "Installing Sketchfab" true

brew_install "megascans-bridge" "Installing Megascans Bridge" true

brew_install "turbosquid" "Installing TurboSquid" true

brew_install "cgtrader" "Installing CGTrader" true

# 3D Motion Capture
brew_install "rokoko" "Installing Rokoko" true

brew_install "ipisoft" "Installing iPi Soft" true

brew_install "perception-neuron" "Installing Perception Neuron" true

brew_install "optitrack" "Installing OptiTrack" true

brew_install "vicon-shogun" "Installing Vicon Shogun" true

# 3D Character Creation
brew_install "character-creator" "Installing Character Creator" true

brew_install "daz-studio" "Installing DAZ Studio" true

brew_install "marvelous-designer" "Installing Marvelous Designer" true

brew_install "fuse" "Installing Fuse" true

brew_install "makehuman" "Installing MakeHuman" true

# AI-Powered 3D Animation
brew_install "plask" "Installing Plask AI" true

brew_install "cascadeur" "Installing Cascadeur" true

brew_install "deepmotion" "Installing DeepMotion" true

brew_install "mixamo" "Installing Mixamo" true

brew_install "motion-library" "Installing Motion Library" true

# UI/UX Design
brew_install "framer" "Installing Framer" true

brew_install "principle" "Installing Principle" true

brew_install "protopie" "Installing ProtoPie" true

brew_install "zeplin" "Installing Zeplin" true

# Generative AI Design Tools
brew_install "galileo-ai" "Installing Galileo AI" true

brew_install "magicul" "Installing MagicUL" true

brew_install "uizard" "Installing Uizard" true

# Writing and Content Creation
brew_install "scrivener" "Installing Scrivener" true

brew_install "ulysses" "Installing Ulysses" true

brew_install "notion" "Installing Notion" true

# Generative AI Writing Tools
brew_install "jasper" "Installing Jasper" true

brew_install "copy-ai" "Installing Copy.ai" true

brew_install "grammarly-desktop" "Installing Grammarly" true

brew_install "writesonic" "Installing Writesonic" true

# Collaboration and Asset Management
brew_install "adobe-creative-cloud-cleaner-tool" "Installing Adobe CC Cleaner" true

brew_install "dropbox" "Installing Dropbox" true

brew_install "google-drive" "Installing Google Drive" true

brew_install "asana" "Installing Asana" true

# Creative Development Tools
brew_install "processing" "Installing Processing" true

brew_install "touchdesigner" "Installing TouchDesigner" true

brew_install "p5js" "Installing p5.js" true

brew_install "arduino" "Installing Arduino IDE" true

# Color and Asset Management
brew_install "colorsnapper" "Installing ColorSnapper" true

brew_install "sip" "Installing Sip" true

brew_install "iconjar" "Installing IconJar" true

brew_install "imageoptim" "Installing ImageOptim" true
