page 50019 "Equipment Activities"
{
    Caption = 'Equipments';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";
    ShowFilter = false;
    Permissions = tabledata "ADT Requisition Header" = rim,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rim;

    layout
    {
        area(Content)
        {

            cuegroup(Equipment)
            {
                Caption = 'Equipments';
                field(Equipments; Rec.Equipments)
                {
                    Caption = 'Equipments';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                }
                field("Equipments Available"; Rec."Equipments Available")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                    StyleExpr = ColorGreen;
                }
                field("Equipments In Use"; Rec."Equipments In Use")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                }
                field("Equipments At Workshop"; Rec."Equipments At Workshop")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                    StyleExpr = ColorYellow;
                }
                field("Equipments Not in Operation"; Rec."Equipments Not in Operation")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                    StyleExpr = ColorRed;
                }
                field("Equipments Due for Servicing"; Rec."Equipments Due for Servicing")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fixed Asset List";
                    StyleExpr = ColorYellow;
                }
            }
        }
    }

    var
        ColorRed: Text;
        ColorGreen: Text;
        ColorYellow: Text;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        ColorRed := 'unfavorable';
        ColorGreen := 'favorable';
        ColorYellow := 'Ambiguous';
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    local procedure CalculateCueFieldValues()
    begin
        // if FieldActive("Normal field") then
        // "Normal field" := 2 + 1 //add some calculation here for normal fields;
    end;

}