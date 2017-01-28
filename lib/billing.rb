require "billing/version"
# Classe do Ruby para manipular arquivos CSV
require "csv"
# Gem para validação de arquivos CSV
require 'csvlint'

module Billing
  extend self
    # Método para validação do arquivo.
    def validate (arq = "#{ARGV[0]}")
      validator = Csvlint::Validator.new( File.new("#{arq}" ))
      validator.valid?
    end

    # Método que encontra os resultados no arquivo passado como parâmetro.
    def find_by_number number
      results = []
      CSV.foreach("#{ARGV[0]}", {:col_sep => ';'}) do |row|
        if row[3] == number
          results << row
        end
      end
      results
    end

    # Método que define o tipo de serviço.
    def call_type tpserv
      type = nil
      case tpserv
      when "Chamadas Locais para Celulares TIM", "Chamadas Locais para Outros Celulares", "Chamadas Locais para Outros Telefones Fixos", "Chamadas Tarifa Zero"
         type = :local
       when "Chamadas Longa Distância: TIM LD 41", "Chamadas Longa Distância: Brasil Telecom", "Chamadas Longa Distância: Telemar", "Chamadas Longa Distância: Embratel", "Chamadas Longa Distância: Telefônica"
         type = :long_distance
       when "TIM Torpedo", "TIM VideoMensagem/FotoMensagem para Celular"
         type = :sms
       when "TIM Wap Fast", "TIM Connect Fast"
         type = :internet
      end
    end

    # Método que realiza as somas para exibição na tela do usuário.
    def sum_bill calls
      results = {local: 0, long_distance: 0, sms: 0, internet: 0}
      calls.each do |call|
        type = call_type call[6]
        if type == :local or type == :long_distance
          results[type] += string_to_minutes call[13]
        elsif type == :sms
          results[type] += 1
        elsif type == :internet
          results[type] += string_to_bytes call[13]
        end
      end
      results
    end

    # Método que converte string para float e realiza o cálculo de minutos.
    def string_to_minutes time_string
      return 0 if time_string.nil?
        minutes = time_string.split("m").first.to_f
        seconds = time_string.split("m").last.split("s").last.to_f
        minutes + seconds / 60
    end

    # Método que converte string para float e realiza o cálculo de bytes.
    def string_to_bytes byte_string
      return 0 if byte_string.nil?
        byte = byte_string.split(" ")
        byte_float = byte[0].to_f
        byte_float * 1000
    end

    # Método para exibir o resultado formatado ao cliente.
    def show_formated_result total
      puts "============ Resultados de sua conta telefônica ========================"
      sleep 1
      puts "Total de minutos em chamadas locais: #{total[:local].round(2)} minutos"
      sleep 1
      puts "Total de minutos em chamadas de longa distância: #{total[:long_distance].round(2)} minutos"
      sleep 1
      puts "Total de SMS enviados: #{total[:sms]}"
      sleep 1
      puts "Total de bytes trafegados de Internet: #{total[:internet].round()} bytes"
      sleep 1
      puts "============ Obrigado por usar o Billing - By Pery Lemke ==============="
    end

    # Método de execução do sistema
    def execute (arq = "#{ARGV[0]}", tel = "#{ARGV[1]}")
      # Executando método para validação do arquivo.
      validate arq
      if validate == true
        # Encontrando as words relacionadas ao numero
        rows_number = find_by_number tel
        # Fazendo os calculos
        total = sum_bill rows_number
        # Imprimindo
        show_formated_result total
      else
        puts "Arquivo inválido - Só é aceito arquivos que tenham delimitadores."
      end
    end

end
