public class ImobiliariaController {
    
    //Definições das variáveis    
    public integer quartos {get; set;}
    public integer banheiros {get; set;}
    public integer sala {get; set;}
    public integer cozinha {get; set;}
    public integer copa {get; set;}
    public integer suite {get; set;}
    public integer vagas {get; set;}
    public integer valor {get; set;}
    public String tipoImovel {get; set;}
    
    
    //Método picklist
    public List<SelectOption> getMinhasOpcoes(){
        //Mapear o campo de lista de seleção/picklist que deseja listar
        Schema.DescribeFieldResult describeResult = Imoveis__c.TipoImovel__c.getDescribe();
        
        //Listar as opções válidas dentro do meu campo
        List<Schema.PicklistEntry> entries = describeResult.getPickListValues();
        
        //Cria variável de retorno do tipo de lista para o objeto SelectOption
        List<SelectOption> optionsToReturn = new List<SelectOption>();
        
        //Adiciona as opções do campo listadas
        for(Schema.PicklistEntry pEntry : entries){        
            //Se a opção está ativa
            //Ou pode aplicar filtro que quiser, caso nãoq ueira mostrar todas as opções
            if(pEntry.isActive()){
                //Adiciona o nome e o valor na variável retorno
                optionsToReturn.add(new SelectOption(pEntry.getValue(), pEntry.getLabel()));
            }
            
        }
        //Retorna a lista de selectOption criamos na variável de retorno
        return optionsToReturn;
    }
    
    
    //Método salvar
    public void salvarImoveis(){
        
        Imoveis__c objImoveis = new Imoveis__c(); //Criando e instanciando um novo objeto
        
        objImoveis.Quartos__c = quartos;
        objImoveis.Banheiro__c = banheiros;
        objImoveis.Sala__c = sala;
        objImoveis.Cozinha__c = cozinha;
        objImoveis.Copa__c = copa;
        objImoveis.Suite__c = suite;
        objImoveis.Garagem__c = vagas;
        objImoveis.Valor__c = valor;
        objImoveis.TipoImovel__c = tipoImovel;
        
        try{
            if(objImoveis.TipoImovel__c != 'Nenhum' && objImoveis.TipoImovel__c != null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Imóvel cadastrado com sucesso!!'));
                insert objImoveis;
                
                //Limpa todos os campos depois de salvar
                quartos = null;
                banheiros = null;
                sala = null;
                cozinha = null;
                copa = null;
                suite = null;
                vagas = null;
                valor = null;
                tipoImovel = null;
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'O campo tipo de imóvel deverá ser preenchido!'));
            }
        }catch(DmlException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Por favor, verifique todos os campos antes de salvar.'));
        }
    }
}
