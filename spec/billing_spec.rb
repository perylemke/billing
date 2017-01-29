require "spec_helper"

describe Billing do
  # Teste de validação com um arquivo válido. Deve retornar True.
  context "test validation with valide file" do
    it "will pass and returns true" do
      arq = 'sample-tim.csv'
      call_method = Billing.validate arq
      expect(call_method).to eq(true)
    end
  end

  # Teste de validação com um arquivo inválido. Deve retornar False.
  context "test validation with invalide file" do
   it "will broke and returns false" do
     arq = 'teste.rb'
     call_method = Billing.validate arq
     expect(call_method).to eq(false)
   end
  end

 # Teste para verificar se um número é válido.
 context "test validation if is a true array" do
   it "will pass a valid number and return a array" do
     arq = "sample-tim.csv"
     tel = "048-8802-2245"
     call_method = Billing.find_by_number arq, tel
     expect(call_method.is_a? Array).to eq(true)
   end
  end

  # Teste para verificar se um número não consta na base.
  context "test validation if is a empty array" do
    it "will pass a invalid number and return a empty array" do
      arq = "sample-tim.csv"
      tel = "1"
      call_method = Billing.find_by_number arq, tel
      expect(call_method.any?).to eq(false)
    end
  end

  # Teste para verificar se é um tipo de ligação Local.
  context "test validation if is a local type" do
    it "will pass a valid option and return a local type" do
      tpserv = "Chamadas Locais para Celulares TIM"
      call_method = Billing.call_type tpserv
      expect(call_method).to eq(:local)
    end
  end

  # Teste para verificar se é um tipo de ligação de longa distância.
  context "test validation if is a long_distance type" do
    it "will pass a valid option and return a long_distance type" do
      tpserv = "Chamadas Longa Distância: TIM LD 41"
      call_method = Billing.call_type tpserv
      expect(call_method).to eq(:long_distance)
    end
  end

  # Teste para verificar se é um tipo SMS.
  context "test validation if is a sms type" do
    it "will pass a valid option and return a sms type" do
      tpserv = "TIM Torpedo"
      call_method = Billing.call_type tpserv
      expect(call_method).to eq(:sms)
    end
  end

  # Teste para verificar se é um tipo Internet.
  context "test validation if is a internet type" do
    it "will pass a valid option and return a internet type" do
      tpserv = "TIM Wap Fast"
      call_method = Billing.call_type tpserv
      expect(call_method).to eq(:internet)
    end
  end

  # Teste para verificar se não é um tipo de ligação Local.
  context "test validation if is NOT a local type" do
    it "will pass a valid option and return a not local type" do
      tpserv = "Chamadas Longa Distância: Brasil Telecom"
      call_method = Billing.call_type tpserv
      expect(call_method).not_to eq(:local)
    end
  end

  # Teste para verificar se não é um tipo de ligação de longa distância.
  context "test validation if is NOT a long_distance type" do
    it "will pass a valid option and return not a long_distance type" do
      tpserv = "Chamadas Locais para Outros Celulares"
      call_method = Billing.call_type tpserv
      expect(call_method).not_to eq(:long_distance)
    end
  end

  # Teste para verificar se é um tipo SMS.
  context "test validation if is NOT a sms type" do
    it "will pass a valid option and return not a sms type" do
      tpserv = "TIM Connect Fast"
      call_method = Billing.call_type tpserv
      expect(call_method).not_to eq(:sms)
    end
  end

  # Teste para verificar se é um tipo Internet.
  context "test validation if is NOT a internet type" do
    it "will pass a valid option and return not a internet type" do
      tpserv = "TIM VideoMensagem/FotoMensagem para Celular"
      call_method = Billing.call_type tpserv
      expect(call_method).not_to eq(:internet)
    end
  end

  # Teste para verificar se é um tipo inválido.
  context "test validation if is invalid type" do
    it "will pass a invalid option and return a nil" do
      tpserv = "foo"
      call_method = Billing.call_type tpserv
      expect(call_method).to eq(nil)
    end
  end

end
