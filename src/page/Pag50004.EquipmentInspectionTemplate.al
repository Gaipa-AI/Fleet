page 50004 "Equipment Inspection Template"
{
    Caption = 'Equipment Inspection Template';
    PageType = List;
    SourceTable = "Equipment Inspection Template";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code;Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Template Code";Rec."Template Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No")
                {
                    ApplicationArea = All;
                }

                field(Sections; Rec.Sections)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
            
        }
    }
    actions
    {
        area(Processing)
        {

        action(Generator)
        {
            Caption = 'Generate Starter';
            ToolTip = 'Generate starter template';
            ApplicationArea = All;
            Image = CreateForm;

            trigger OnAction()
              var 
                FormHeader : Record "Form Header";
            begin
                //FormHeader.GenerateSections1();
                Rec.CreateInspectionTemplate();

            end;


        }
        }
                
    }
}
