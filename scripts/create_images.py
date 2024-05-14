import os
from subprocess import call, CalledProcessError

from common import set_logger
from aims_saas_api_client import AIMSSaaSAPIClient

from concurrent.futures import ThreadPoolExecutor, as_completed


logger = set_logger(log_file='./scripts/logs/create_images.log')

def generate_image(jar_bin, xml_path, xsl_path, png_path):
    """
    Generates image using FOP.

    Args:
    - jar_bin: Path to the directory containing fop.jar.
    - xml_path: Path to the input XML file.
    - xsl_path: Path to the XSL file.
    - png_path: Path to save the generated PNG image.

    Returns: None
    """
    logger.info(f"Generating image {png_path}")
    
    cmd = ["java", "-jar", os.path.join(jar_bin, "fop.jar"), "-c", "conf.xml", "-xml", xml_path, "-xsl", xsl_path, "-png", png_path]
    
    try:
        # Use cwd parameter to execute the command in the jar_bin directory.
        logger.info(f"cmd: {cmd}")
        call(cmd, cwd=jar_bin)
        logger.info(f"Image generator finshed for file {png_path}.")

    except CalledProcessError:
        logger.error(f"Error executing command for {xml_path} using {xsl_path}.")
    except Exception as e:
        logger.error(f"Unexpected error generating image for {xml_path} using {xsl_path}. Error: {str(e)}")

def generate_image_threaded(jar_bin, xml_path, xsl_path, png_path):
    pass

def set_font_dir(font_dir:str, conf_file:str):
    """
    Sets the font directory in the conf.xml file.

    Args:
    - font_dir: Path to the directory containing the fonts.
    - conf_file: Path to the conf.xml file.

    Returns: None
    """
    #conf_file = os.path.abspath('./scripts/conf.xml')
    
    with open(conf_file, 'r') as f:
        lines = f.readlines()
    with open(conf_file, 'w') as f:
        for line in lines:
            if "<directory>" in line:
                f.write(f"    			<directory>{font_dir}</directory>\n")
            else:
                f.write(line)
    


def main():
    # Set the paths
    jar_bin_dir = os.path.abspath('./scripts/bin')
    xsl_dir = os.path.abspath('./')
    xml_dir = os.path.abspath('./scripts/xml_data')
    images_dir = os.path.abspath('./scripts/images')
    font_dir = os.path.abspath('./scripts/fonts')
    conf_file = os.path.abspath('./scripts/bin/conf.xml')

    # Check if images directory exists, if not create it
    if not os.path.exists(images_dir):
        os.makedirs(images_dir)

    # Set the font directory in the conf.xml file
    set_font_dir(font_dir=font_dir, conf_file=conf_file)

    # Get all the XML / XSL files from the directory
    xml_files = [f for f in os.listdir(xml_dir) if f.endswith('.xml')]
    xsl_files = [f for f in os.listdir(xsl_dir) if f.endswith('.xsl')]
 
    

    with ThreadPoolExecutor(max_workers=8) as executor:
        for xsl_file in xsl_files:
            futures = []
            logger.info(f"Processing XSL file: {xsl_file}")
            for xml_file in xml_files:
                article_id, _ = os.path.splitext(xml_file)
                template_name, _ = os.path.splitext(xsl_file)

                xsl_path = os.path.join(xsl_dir, xsl_file)
                xml_path = os.path.join(xml_dir, xml_file)
                png_path = os.path.join(images_dir, f"{article_id}_{template_name}.png")

                logger.info(f"Appending to executor {png_path}.")
                futures.append(executor.submit(generate_image, jar_bin_dir, xml_path, xsl_path, png_path))
                #generate_image(jar_bin=jar_bin_dir,xml_path=xml_path, xsl_path=xsl_path, png_path=png_path)
            
        # Wait for all the futures to complete
        for future in as_completed(futures):
            result = future.result()  # This line can be used to get the result from process_files if needed



if __name__ == "__main__":
    
    main()

