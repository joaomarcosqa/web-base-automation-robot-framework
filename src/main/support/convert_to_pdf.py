import sys
import os
import shutil
import img2pdf
from datetime import datetime

EXECUTION_FOLDER = datetime.now().strftime("%d-%m-%Y")

def main(input_dir, output_pdf):
    input_dir = os.path.abspath(input_dir)
    output_pdf = os.path.abspath(output_pdf)
    output_dir = os.path.dirname(output_pdf)

    print(f"Diretório de entrada: {input_dir}")
    print(f"PDF de saída: {output_pdf}")

    if not os.path.isdir(input_dir):
        print(f"Erro: Diretório inexistente -> {input_dir}")
        sys.exit(1)

    imagens = [f for f in os.listdir(input_dir) if f.lower().endswith(".png")]
    imagens.sort()

    if not imagens:
        print("Nenhuma imagem encontrada.")
        sys.exit(1)

    caminhos = [os.path.join(input_dir, i) for i in imagens]

    os.makedirs(output_dir, exist_ok=True)

    if os.path.exists(output_pdf):
        try:
            os.remove(output_pdf)
            print(f"PDF existente removido: {output_pdf}")
        except Exception as e:
            print(f"Erro ao remover PDF existente: {e}")
            sys.exit(6)

    try:
        pdf_bytes = img2pdf.convert([os.path.abspath(p) for p in caminhos])
        with open(output_pdf, "wb") as f:
            f.write(pdf_bytes)
        print(f"PDF criado com sucesso: {output_pdf}")
    except Exception as e:
        print(f"Erro ao criar o PDF: {e}")
        sys.exit(3)

    try:
        shutil.rmtree(input_dir)
        print(f"Diretório de screenshots removido com sucesso: {input_dir}")
    except Exception as e:
        print(f"Erro ao remover diretório de screenshots: {e}")
        sys.exit(5)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python convert_to_pdf.py <input_dir> <output_pdf>")
        sys.exit(2)

    main(sys.argv[1], sys.argv[2])

if __name__ == "__robot__":
    VARIABLES = {
        "EXECUTION_FOLDER": EXECUTION_FOLDER
    }